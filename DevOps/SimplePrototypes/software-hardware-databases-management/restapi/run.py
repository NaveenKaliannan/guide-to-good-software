# Import necessary modules
from flask import Flask, request, jsonify, Response
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_cors import CORS
from flask_login import LoginManager, UserMixin
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime, timedelta
from tabulate import tabulate
import os

# Initialize Flask application
app = Flask(__name__)

# Configuration
# Load configuration from environment variables
app.config['SECRET_KEY'] = os.environ.get('SECRET_KEY')
app.config['SQLALCHEMY_DATABASE_URI'] = f"postgresql://{os.environ.get('DB_USERNAME')}:{os.environ.get('DB_PASSWORD')}@{os.environ.get('DB_HOST')}:{os.environ.get('DB_PORT')}/{os.environ.get('DB_NAME')}"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['JWT_SECRET_KEY'] = os.environ.get('JWT_SECRET_KEY')
app.config['JWT_ACCESS_TOKEN_EXPIRES'] = timedelta(seconds=int(os.environ.get('JWT_ACCESS_TOKEN_EXPIRES')))

# Initialize database
db = SQLAlchemy(app)
migrate = Migrate(app, db)

# Set up authentication and JWT
login_manager = LoginManager(app)
login_manager.login_view = 'login'
jwt = JWTManager(app)

DEFAULT_USER_ID = 1  # Default user ID (replace with appropriate value)

# Utility function to get current timestamp
def default_created_at():
    return datetime.now()

# Models
class User(db.Model, UserMixin):
    """
    User model representing system users.
    """
    id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(100), nullable=False)
    last_name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password = db.Column(db.String(1000), nullable=False)
    dob = db.Column(db.Date, nullable=False)
    expertise = db.Column(db.String(50), nullable=False)
    experience = db.Column(db.Integer, nullable=False)
    created_at = db.Column(db.DateTime, default=default_created_at)
    role = db.Column(db.String(50), default='user')
    department = db.Column(db.String(50), nullable=False)

    def to_dict(self):
        """
        Convert user object to dictionary.
        """
        return {
            'id': self.id,
            'first_name': self.first_name,
            'last_name': self.last_name,
            'email': self.email,
            'dob': self.dob.isoformat() if self.dob else None,
            'expertise': self.expertise,
            'experience': self.experience,
            'role': self.role,
            'department': self.department
        }

class Software(db.Model):
    """
    Software model representing software entries.
    """
    __tablename__ = 'software'
    
    id = db.Column(db.Integer, primary_key=True)
    unique_id = db.Column(db.String(50), unique=True, nullable=True)
    name = db.Column(db.String(100), nullable=False)
    version = db.Column(db.String(20), nullable=False)
    description = db.Column(db.String(500), nullable=True)
    added_by = db.Column(db.String(100), nullable=False)  # Store username

class Hardware(db.Model):
    """
    Hardware model representing hardware entries.
    """
    __tablename__ = 'hardware'
    
    id = db.Column(db.Integer, primary_key=True)
    unique_id = db.Column(db.String(50), unique=True, nullable=True)
    name = db.Column(db.String(100), nullable=False)
    version = db.Column(db.String(20), nullable=True)  # Allow version to be NULL
    specifications = db.Column(db.String(500), nullable=True)
    added_by = db.Column(db.String(100), nullable=False)

class SoftwareHardware(db.Model):
    """
    SoftwareHardware model representing the relationship between software and hardware.
    """
    __tablename__ = 'software_hardware'
    
    id = db.Column(db.Integer, primary_key=True)
    unique_id = db.Column(db.String(50), unique=True, nullable=True)
    software_name = db.Column(db.String(100), nullable=False)
    software_version = db.Column(db.String(20), nullable=False)
    software_description = db.Column(db.String(500), nullable=True)
    software_added_by = db.Column(db.String(100), nullable=False)  # Store username
    hardware_name = db.Column(db.String(100), nullable=False)
    hardware_specifications = db.Column(db.String(250), nullable=False)
    hardware_added_by = db.Column(db.String(100), nullable=False)  # Store username


# Error handling
@app.errorhandler(500)
def internal_error(error):
    """
    Global error handler for 500 Internal Server Error.
    
    Args:
        error: The error that occurred.

    Returns:
        A JSON response with an error message and 500 status code.
    """
    db.session.rollback()  # Roll back the database session to prevent data inconsistency
    return jsonify({"message": "An internal server error occurred", "error": str(error)}), 500

# User routes
@app.route('/api/signup', methods=['POST'])
def sign_up():
    """
    Handle user registration.

    Expects JSON data with user details including first_name, last_name, email, password, department, dob, expertise, and experience.

    Returns:
        A JSON response indicating success or failure of the registration process.
    """
    data = request.json
    first_name = data.get('first_name')
    last_name = data.get('last_name')
    email = data.get('email')
    password = data.get('password')
    department = data.get('department')

    # Validate department
    if department not in ['software', 'hardware', 'software-hardware']:
        return jsonify({'message': 'Invalid department'}), 400

    try:
        # Hash the password for security
        hashed_password = generate_password_hash(password, method='sha256')
        
        # Create new user object
        new_user = User(
            first_name=first_name[:100],  # Limit first name to 100 characters
            last_name=last_name[:100],    # Limit last name to 100 characters
            email=email,
            password=hashed_password,
            dob=datetime.strptime(data['dob'], '%Y-%m-%d').date(),
            expertise=data['expertise'],
            experience=data['experience'],
            department=department
        )
        
        # Add and commit the new user to the database
        db.session.add(new_user)
        db.session.commit()
        return jsonify({'message': 'User registered successfully'}), 201
    except Exception as e:
        # Roll back the session in case of any error
        db.session.rollback()
        return jsonify({'message': str(e)}), 400

@app.route('/api/signin', methods=['POST'])
def sign_in():
    """
    Handle user sign-in.

    Expects JSON data with email and password.

    Returns:
        A JSON response with an access token if authentication is successful, or an error message if not.
    """
    data = request.json
    user = User.query.filter_by(email=data['email']).first()

    # Check if user exists and password is correct
    if user and check_password_hash(user.password, data['password']):
        # Create and return an access token
        access_token = create_access_token(identity=user.id)
        return jsonify({'message': 'Sign in successful', 'token': access_token}), 200

    return jsonify({'message': 'Invalid credentials'}), 401



@app.route('/api/software', methods=['POST'])
@jwt_required()
def add_software():
    """
    Add or update software information.
    
    This endpoint is accessible only to users in the 'software' or 'software-hardware' departments.
    It adds a new software entry or updates an existing one based on the unique_id.
    
    Returns:
        JSON response indicating success or failure.
    """
    current_user_id = get_jwt_identity()
    current_user = User.query.get(current_user_id)

    # Check user permissions
    if current_user.department not in ['software', 'software-hardware']:
        return jsonify({"message": "Access denied"}), 403

    data = request.json
    unique_id = data.get('unique_id')
    name = data.get('name')
    version = data.get('version')
    description = data.get('description')

    existing_software = Software.query.filter_by(unique_id=unique_id).first()

    if existing_software:
        # Update existing software
        existing_software.name = name
        existing_software.version = version
        existing_software.description = description
    else:
        # Create new software entry
        existing_software = Software(
            name=name,
            version=version,
            description=description,
            added_by=current_user.first_name,
            unique_id=unique_id
        )
        db.session.add(existing_software)

    db.session.commit()

    # Update corresponding SoftwareHardware entry
    update_software_hardware(existing_software)

    return jsonify({"message": "Software added/updated successfully"}), 201

@app.route('/api/hardware', methods=['POST'])
@jwt_required()
def add_hardware():
    """
    Add or update hardware information.
    
    This endpoint is accessible only to users in the 'hardware' or 'software-hardware' departments.
    It adds a new hardware entry or updates an existing one based on the unique_id.
    
    Returns:
        JSON response indicating success or failure.
    """
    current_user_id = get_jwt_identity()
    current_user = User.query.get(current_user_id)

    # Check user permissions
    if current_user.department not in ['hardware', 'software-hardware']:
        return jsonify({"message": "Access denied"}), 403

    data = request.json
    unique_id = data.get('unique_id')
    name = data.get('name')
    version = data.get('version')
    specifications = data.get('specifications')

    if not version:
        return jsonify({"message": "Version is required"}), 400

    existing_hardware = Hardware.query.filter_by(unique_id=unique_id).first()

    if existing_hardware:
        # Update existing hardware
        existing_hardware.name = name
        existing_hardware.version = version
        existing_hardware.specifications = specifications
    else:
        # Create new hardware entry
        existing_hardware = Hardware(
            name=name,
            version=version,
            specifications=specifications,
            unique_id=unique_id,
            added_by=current_user.first_name
        )
        db.session.add(existing_hardware)

    db.session.commit()

    # Update corresponding SoftwareHardware entry
    update_hardware_software(existing_hardware, current_user)

    return jsonify({"message": "Hardware added/updated successfully"}), 201

def update_hardware_software(hardware, current_user):
    """
    Update or create a SoftwareHardware entry based on hardware information.
    
    Args:
        hardware: The Hardware object to update or create an entry for.
        current_user: The current user making the update.
    """
    software = Software.query.filter_by(unique_id=hardware.unique_id).first()
    software_hardware = SoftwareHardware.query.filter_by(unique_id=hardware.unique_id).first()

    if not software_hardware:
        # Create new SoftwareHardware entry
        software_hardware = SoftwareHardware(
            unique_id=hardware.unique_id,
            software_name=software.name if software else "N/A",
            software_version=software.version if software else "N/A",
            software_description=software.description if software else "N/A",
            software_added_by=current_user.first_name if current_user else "N/A",
            hardware_name=hardware.name,
            hardware_specifications=hardware.specifications,
            hardware_added_by=current_user.first_name if current_user else "N/A"
        )
        db.session.add(software_hardware)
    else:
        # Update existing SoftwareHardware entry
        software_hardware.hardware_name = hardware.name
        software_hardware.hardware_specifications = hardware.specifications
        software_hardware.hardware_added_by = current_user.first_name if current_user else "N/A"

        if not software:
            software_hardware.software_name = "N/A"
            software_hardware.software_version = "N/A"
            software_hardware.software_description = "N/A"
        else:
            software_hardware.software_name = software.name
            software_hardware.software_version = software.version
            software_hardware.software_description = software.description

    db.session.commit()

def update_software_hardware(software):
    """
    Update or create a SoftwareHardware entry based on software information.
    
    Args:
        software: The Software object to update or create an entry for.
    """
    software_hardware = SoftwareHardware.query.filter_by(unique_id=software.unique_id).first()
    hardware = Hardware.query.filter_by(unique_id=software.unique_id).first()

    if not software_hardware:
        # Create new SoftwareHardware entry
        software_hardware = SoftwareHardware(
            unique_id=software.unique_id,
            software_name=software.name,
            software_version=software.version,
            software_description=software.description,
            software_added_by=software.added_by,
            hardware_name=hardware.name if hardware else "N/A",
            hardware_specifications=hardware.specifications if hardware else "N/A",
            hardware_added_by=hardware.added_by if hardware else "N/A"
        )
        db.session.add(software_hardware)
    else:
        # Update existing SoftwareHardware entry
        software_hardware.software_name = software.name
        software_hardware.software_version = software.version
        software_hardware.software_description = software.description
        
        if hardware:
            software_hardware.hardware_name = hardware.name
            software_hardware.hardware_specifications = hardware.specifications
            software_hardware.hardware_added_by = hardware.added_by if hardware else "N/A"
        else:
            software_hardware.hardware_name = "N/A"
            software_hardware.hardware_specifications = "N/A"
            software_hardware.hardware_added_by = "N/A"

    db.session.commit()

@app.route('/api/databases', methods=['GET'])
@jwt_required()
def get_databases():
    """
    Retrieve and display all database tables (Software, Hardware, SoftwareHardware).
    
    This endpoint is accessible only to users in the 'software-hardware' department.
    
    Returns:
        A plain text response containing formatted tables of all database entries.
    """
    current_user_id = get_jwt_identity()
    current_user = User.query.get(current_user_id)

    # Check user permissions
    if current_user.department not in ['software-hardware']:
        return jsonify({"message": "Access denied"}), 403

    # Fetch and sort data from all tables
    software_list = Software.query.order_by(Software.id.asc()).all()
    hardware_list = Hardware.query.order_by(Hardware.id.asc()).all()
    software_hardware_list = SoftwareHardware.query.order_by(SoftwareHardware.id.asc()).all()

    # Format tables using tabulate
    software_table = tabulate(
        [[s.id, s.unique_id, s.name, s.version, s.description] for s in software_list],
        headers=['ID', 'Unique ID', 'Name', 'Version', 'Description'],
        tablefmt='grid'
    )

    hardware_table = tabulate(
        [[h.id, h.unique_id, h.name, h.specifications] for h in hardware_list],
        headers=['ID', 'Unique ID', 'Name', 'Specifications'],
        tablefmt='grid'
    )

    software_hardware_table = tabulate(
        [[sh.id, sh.unique_id, sh.software_name, sh.software_version, 
          sh.software_description, sh.software_added_by, sh.hardware_name, 
          sh.hardware_specifications, sh.hardware_added_by] for sh in software_hardware_list],
        headers=['ID', 'Unique ID', 'Software Name', 'Software Version', 
                 'Software Description', 'Software Info Added By', 'Hardware Name', 
                 'Hardware Specifications', 'Hardware Info Added By'],
        tablefmt='grid'
    )

    # Combine all tables into a single response
    result = f"Software Table:\n{software_table}\n\n" \
             f"Hardware Table:\n{hardware_table}\n\n" \
             f"Software-Hardware Table:\n{software_hardware_table}"

    return Response(result, mimetype='text/plain')


@app.route('/api/me', methods=['GET'])
@jwt_required()
def get_current_user():
    """
    Retrieve information about the currently authenticated user.

    This endpoint requires a valid JWT token for authentication.

    Returns:
        JSON: A dictionary containing the user's information if found.
        
    Response codes:
        200: Successfully retrieved user information.
        404: User not found.
    """
    # Get the user ID from the JWT token
    current_user_id = get_jwt_identity()
    
    # Query the database for the user
    current_user = User.query.get(current_user_id)
    
    if current_user:
        # If the user is found, return their information
        return jsonify(current_user.to_dict()), 200
    
    # If the user is not found, return an error message
    return jsonify({"message": "User not found"}), 404


if __name__ == '__main__':
    """
    Run the Flask application.

    This block is executed only if the script is run directly (not imported as a module).
    It starts the Flask development server.

    Configuration:
        host: '0.0.0.0' allows connections from any IP address.
        port: 5000 is the port number on which the server will listen.
        debug: True enables debug mode, providing detailed error messages and auto-reloading.
    """
    app.run(host='0.0.0.0', port=5000, debug=True)


