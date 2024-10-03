# Use Python 3.9 as the base image
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Install dependencies
#RUN pip install --no-cache-dir -r requirements.txt
COPY ./restapi/requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy all files from the current directory to the container
CCOPY ./restapi/* ./

# Make the script executable
RUN chmod +x /app/start.sh

# Set the FLASK_APP environment variable
ENV FLASK_APP=run.py

# Expose port 5000 to the outside world
EXPOSE 5000

# Command to run the startup script
CMD ["/app/start.sh"]
