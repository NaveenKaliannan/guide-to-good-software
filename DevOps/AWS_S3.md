# AWS S3 – Overview & Key Concepts

Amazon S3 (Simple Storage Service) is an object storage service that allows users to store and retrieve any amount of data at any time. It is designed for 99.999999999% (11 9's) of durability and is commonly used for backup, archiving, disaster recovery, and big data analytics.

---

## 🚀 Use Cases

* **Backup & Storage:** Store application data, media, logs, and more.
* **Disaster Recovery:** Replicate data across AWS regions for business continuity.
* **Archiving:** Move infrequently accessed data to low-cost storage classes (e.g., Glacier).
* **Static Website Hosting:** Host HTML/CSS/JS websites directly from an S3 bucket.
* **Big Data & Analytics:** Store raw data for tools like Athena, EMR, Redshift, and Glue.
* **Content Distribution:** Pair with **CloudFront** for global, low-latency delivery.
* **Data Lakes:** Centralize structured and unstructured data for ML workloads.

---

## 🗂️ Buckets & Objects

S3 stores data as **objects** inside **buckets**.

* **Object:** Consists of the file (data) + metadata.
* **Bucket:** A top-level container for objects. 
    * Buckets are created in a **specific AWS Region**.
    * Bucket names must be **globally unique** across all AWS accounts.



### 🌍 Bucket Naming Rules

| Feature | Rule |
| :--- | :--- |
| **Length** | 3 – 63 characters |
| **Characters** | Lowercase letters, numbers, dots (`.`), and hyphens (`-`) |
| **Start/End** | Must start and end with a letter or number |
| **Prohibited** | Uppercase letters, underscores (`_`), IP-like formats (e.g., 192.168.1.1) |
| **Reserved** | Cannot start with `xn--` or end with `-s3alias` |

---

## 🔑 Object Components & Structure

Each object is identified by a **Key** (the full path). S3 uses a **flat structure**, not a true file system. "Folders" are visual illusions created using **Prefixes** and **Delimiters** (e.g., `/`).

**Example S3 URI:** `s3://my-bucket-name/project/images/logo.png`

### 📦 Data & Size Limits
* **Maximum Object Size:** 5 TB.
* **Single PUT Limit:** 5 GB (recommended to use Multipart Upload for anything over 100 MB).
* **Multipart Upload:** Required for objects > 5 GB. It improves throughput and allows for resuming failed uploads.

### 🏷️ Metadata & Tags
* **System Metadata:** Managed by S3 (e.g., Creation Date, Size, Storage Class, ETag).
* **User Metadata:** Custom key-value pairs (e.g., `x-amz-meta-author: bob`). Note: To change metadata, you must replace the object.
* **Tags:** Used for cost allocation and lifecycle policies. (Max 10 tags per object).

---

## 🕓 Versioning
When enabled, versioning protects against accidental deletes or overwrites.
* **Retrieval:** You can retrieve any previous version of an object.
* **Deletes:** Deleting an object without a version ID creates a **Delete Marker**. To permanently delete, you must specify the Version ID.
* **Suspension:** Versioning can be "Suspended" but once enabled, it can never be fully "Disabled" (only suspended).

---

## 🛡️ Security & Access Control
* **IAM Policies:** User-based access.
* **Bucket Policies:** Resource-based access (useful for cross-account or public access).
* **ACLs (Access Control Lists):** Legacy method for individual object access (mostly deprecated in favor of policies).
* **Encryption:** Supports encryption in transit (SSL/TLS) and at rest (SSE-S3, SSE-KMS, or SSE-C).
