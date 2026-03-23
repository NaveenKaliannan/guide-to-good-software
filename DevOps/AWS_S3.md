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

# 🕓 AWS S3 Versioning: The Lifecycle Story

Amazon S3 Versioning is a means of keeping multiple variants of an object in the same bucket. It allows you to preserve, retrieve, and restore every version of every object stored in your buckets.

---

## 📕 Chapter 1: The "Null" Era (Before Versioning)
When a bucket is created, versioning is **Disabled** by default.

* **The Upload:** You upload `report.pdf`.
* **The ID:** S3 assigns it a version ID of `null`.
* **The Risk:** If you upload a new version or hit "Delete," the original data is overwritten or erased permanently. 

> **State:** `report.pdf` (Version ID: `null`)

---

## 📗 Chapter 2: The Safety Net (Versioning Enabled)
You toggle Versioning to **Enabled**. S3 now begins tracking every change with unique, randomly generated strings.

* **New Uploads:** Each save creates a new layer in the stack.
* **The Stack:**
    * `report.v3` (Latest)
    * `report.v2`
    * `report.v1`
    * `report.null` (The original file is still there!)



---

## 📙 Chapter 3: The Delete Marker (The Plot Twist)
You select `report.pdf` and click **Delete**. To the naked eye, the file is gone. But in the background, S3 has simply performed a "soft delete."

1. S3 places a **Delete Marker** at the top of the stack. In the world of AWS S3, a Delete Marker is essentially a "ghost" or a "placeholder" that S3 uses to hide an object without actually erasing the data. Think of it as a "Post-it note" stuck on top of a file that says "This is deleted," even though the file is still sitting right underneath it.
2. The Delete Marker becomes the **Current Version**.
3. Any simple `GET` request for the file now returns a **404 Not Found**.

**The Version Stack:**
1.  `[Current] Delete Marker` (ID: `d-9999`)
2.  `report.v3`
3.  `report.v2`
4.  `report.null`

---

## 📘 Chapter 4: The Great Restoration
Because the versions still exist under the Delete Marker, you have two ways to "Time Travel":

1.  **Direct Access:** You can still download `report.v2` specifically by providing its Version ID.
2.  **The Undo:** If you delete the **Delete Marker** itself, the previous version (`v3`) automatically becomes the "Current Version" again. The file "reappears" in your bucket instantly.

---

## 📑 Technical Summary & Rules

| Scenario | Behavior |
| :--- | :--- |
| **Versioning Status** | Can be **Enabled** or **Suspended** (Never disabled). |
| **The `null` Version** | Objects uploaded *before* versioning was enabled keep `null` as their ID. |
| **Storage Costs** | You pay for **every version** stored. 5 versions of a 1GB file = 5GB of billed storage. |
| **MFA Delete** | You can require Multi-Factor Authentication to permanently delete a version. |
| **Permanent Deletion** | To actually clear space, you must delete a specific **Version ID**. |

---

### 💡 Real-World Analogy
Think of S3 versioning like a **stack of clear acetate sheets**:
* **Normal File:** You write on the sheet.
* **New Version:** You place a new sheet on top. You can see the old ones underneath, but you only read the top one.
* **Deletion:** You place an opaque black sheet (The Delete Marker) on top. You can't see anything anymore, but the sheets are still there. Remove the black sheet, and your data is back.



