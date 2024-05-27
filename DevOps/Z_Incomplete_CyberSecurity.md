# CyberSecurity

### Terminology
* **Informaiton security** is an act of protecting data and information from unauthorized access, use, disclosure, disruption, modification, or destruction and etc.
1. CIA (confidentiality, integrity, and availability) triad is a fundamental model in information security that guides the development of comprehensive security strategies to protect information assets
2. **Confidentiality** protects information from unauthorized access and misuse. It ensures that sensitive data is only accessible to authorized parties. Confidentiality measures include access controls, authentication, and encryption.
3. **Integrity** ensures that data is trustworthy, complete, and has not been accidentally or maliciously altered. It provides assurance in the accuracy and completeness of information. Integrity measures include access controls, transaction logging, and data backup/recovery.
4. **Availability** ensures that authorized users have reliable and timely access to information and resources when needed. It protects against disruptions to service, such as hardware failures, network issues, and denial-of-service attacks. Availability measures include redundancy, monitoring, and incident response planning.
5. **Non-repudiation** refers to the ability to prove that a specific action or event has taken place, such that the involved parties cannot later deny their participation or involvement. Example: Suppose Mallory buys a cell phone for $100 and pays with a paper check that she signs. Later, Mallory claims that the check is a forgery and tries to deny making the purchase. However, Mallory's signature on the check provides non-repudiation - it guarantees that only Mallory could have signed the check, and she cannot successfully deny authorizing the payment. The signature serves as proof of Mallory's involvement in the transaction, preventing her from repudiating it later. In contrast, a physical signature on paper is relatively easy to forge, making non-repudiation more difficult to prove. Digital signatures, which use cryptographic techniques, are much harder to forge and provide a stronger guarantee of non-repudiation.
6. **Authentication**  is the process of verifying the identity of a user, device, or system before granting them access to a resource or system
* **Information system security** is an act of protecting the systems that holds the data and information.

* **AAA (Authentication, Authorization, and Accounting) security framework**
1. Authentication: When a remote user tries to access the corporate network, they are prompted to enter their username and password. The user's credentials are sent to a AAA server (e.g., RADIUS or TACACS+) for verification. The AAA server checks the user's credentials against a database of authorized users. If the credentials are valid, the user is authenticated and allowed to proceed.
2. Authorization: After successful authentication, the AAA server determines what resources and services the user is authorized to access. This is done by associating the user's identity with a set of access privileges and permissions stored in the AAA server's database. For example, a regular employee may be authorized to access email, file shares, and basic web applications, while an IT administrator may be  granted access to configure network devices and security settings. The AAA server communicates the user's authorized access rights back to the network device, which then enforces those permissions.
3. Accounting: As the user interacts with the network resources, the AAA server logs their activity, such as: The user's identity The network services accessed The duration of the session The amount of data transferred This accounting information can be used for various purposes, such as: Auditing user activity for security and compliance purposes Generating usage reports for billing or capacity planning
Analyzing trends and patterns to identify potential security issues or optimize network performance

### 

### Data integreity and security
* **md5sum and sha1sum** are command-line utilities used to calculate and verify cryptographic hash functions for files on Unix-like operating systems, including Linux. A cryptographic hash function is a mathematical algorithm that takes an input data of arbitrary size and produces a fixed-size output, known as a hash value. Commonly used cryptographic hash functions include MD5 (now considered insecure), SHA-1 (also insecure for some applications), SHA-2 (SHA-256, SHA-512), and SHA-3. The choice of hash function depends on the specific security requirements, desired hash length, and performance considerations for a given application. 256-bit (32-byte) hash outputs are considered secure enough for most applications. Common hash function output sizes recommended by standards and experts are 256 bits (SHA-256, SHA3-256) and 512 bits (SHA-512, SHA3-512). These are considered sufficiently secure for most use cases. The choice of hash length depends on the specific security requirements and performance considerations of the application. For most general-purpose applications, 256-bit hashes strike a good balance between security and efficiency.
```bash
#!/bin/bash

# Function to calculate SHA-256 hash
calculate_sha256() {
    local file="$1"
    sha256sum "$file" | awk '{print $1}'
}

# Function to calculate SHA-3 hash
calculate_sha3() {
    local file="$1"
    rhash --sha3-256 "$file"
}

# Function to process a single file
process_file() {
    local file="$1"

    echo "Processing file: $file"

    sha256_hash=$(calculate_sha256 "$file")
    echo "SHA-256: $sha256_hash"

    sha3_hash=$(calculate_sha3 "$file")
    echo "SHA-3: $sha3_hash"

    echo ""
}

# Main script
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <file1> [file2] [file3] ..."
    exit 1
fi

for file in "$@"; do
    if [ -f "$file" ]; then
        process_file "$file"
    else
        echo "Error: $file is not a regular file"
    fi
done
```
