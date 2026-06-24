# YandexLoop

YandexLoop is an automated reconnaissance pipeline designed for bug bounty hunters and security researchers. This tool automates the process of gathering sensitive information, exposed assets, and forgotten endpoints using Yandex dorking.

Most reconnaissance tools focus on Google; Yandex often indexes different layers of an attack surface, including old routes, forgotten API paths, staging environments, and exposed configuration files.

## Features

* Automated Dorking Pipeline: Loops through a comprehensive set of targeted queries.
* Categorized Results: Automatically buckets findings into:
  * api.txt (Endpoints, GraphQL, Swagger/OpenAPI)
  * javascript.txt (JS files, Webpack, static assets)
  * auth_admin.txt (Login pages, Dashboards, Signin)
  * environments.txt (Staging, Dev, Beta, Internal paths)
  * files.txt (JSON, XML, ENV, LOG, configuration files)
  * documents.txt (PDF, DOC, XLS, CSV)
* Safe & Efficient: Includes rate-limiting (sleep intervals) to help avoid IP blocks.
* Clean Output: Automatically removes noise and duplicates from search results.

## Requirements

* Linux environment[cite: 1]
* curl, grep, sed, coreutils, python3[cite: 1]

## Installation

```bash
# Clone the repository
git clone [https://github.com/YOUR_USERNAME/yandex-loop.git](https://github.com/YOUR_USERNAME/yandex-loop.git)
cd yandex-loop

# Make the script executable
chmod +x yadexloop.sh

# Install requirements (if not already installed)
sudo apt update
sudo apt install curl grep sed coreutils python3 -y

Usage
./yadexloop.sh example.com

Output
The results will be saved in the yandex-loop-output/example.com/ directory[cite: 1]:

urls.txt: The full list of unique URLs found[cite: 1].

api.txt: API-related paths[cite: 1].

javascript.txt: JavaScript and static frontend assets[cite: 1].

auth_admin.txt: Authentication and admin panels[cite: 1].

environments.txt: Development, staging, and internal environment paths[cite: 1].

files.txt: Potentially sensitive file types (JSON, LOG, etc.)[cite: 1].

documents.txt: Office documents (PDF, DOCX, etc.)[cite: 1].

Legal Disclaimer
This tool is designed for educational purposes and authorized security testing (bug bounty programs) only[cite: 1]. Do not use this tool against targets you do not have permission to test[cite: 1]. Unauthorized access to computer systems may be illegal[cite: 1]. The author is not responsible for any misuse of this tool[cite: 1].

Author: https://x.com/ladebw
