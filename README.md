YandexLoop

YandexLoop is an automated reconnaissance pipeline designed for bug bounty hunters and security researchers. This tool automates the process of gathering sensitive information, exposed assets, and forgotten endpoints using Yandex dorking.

Most reconnaissance tools focus on Google; Yandex often indexes different layers of an attack surface, including old routes, forgotten API paths, staging environments, and exposed configuration files.

Features

Automated Dorking Pipeline: Loops through a comprehensive set of targeted queries.

Categorized Results: Automatically buckets findings into:

api.txt (Endpoints, GraphQL, Swagger/OpenAPI)

javascript.txt (JS files, Webpack, static assets)

auth_admin.txt (Login pages, Dashboards, Signin)

environments.txt (Staging, Dev, Beta, Internal paths)

files.txt (JSON, XML, ENV, LOG, configuration files)

documents.txt (PDF, DOC, XLS, CSV)

Safe & Efficient: Includes rate-limiting (sleep intervals) to help avoid IP blocks.

Clean Output: Automatically removes noise and duplicates from search results.

Requirements

Linux environment

curl, grep, sed, coreutils, python3

Installation

Clone the repository
git clone https://github.com/YOUR_USERNAME/yandex-loop.git
cd yandex-loop

Make the script executable
chmod +x yadexloop.sh

Install requirements (if not already installed)
sudo apt update
sudo apt install curl grep sed coreutils python3 -y

Usage

./yadexloop.sh example.com

Output

The results will be saved in the yandex-loop-output/example.com/ directory:

urls.txt: The full list of unique URLs found.

api.txt: API-related paths.

javascript.txt: JavaScript and static frontend assets.

auth_admin.txt: Authentication and admin panels.

environments.txt: Development, staging, and internal environment paths.

files.txt: Potentially sensitive file types (JSON, LOG, etc.).

documents.txt: Office documents (PDF, DOCX, etc.).

Legal Disclaimer

This tool is designed for educational purposes and authorized security testing (bug bounty programs) only. Do not use this tool against targets you do not have permission to test. Unauthorized access to computer systems may be illegal. The author is not responsible for any misuse of this tool.

Author: https://x.com/ladebw
