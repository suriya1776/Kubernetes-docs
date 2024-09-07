set -euo pipefail

- -e: Exit immediately if any command within the script exits with a non-zero status
- -u: Treat unset variables as an error and exit immediately
- -o pipefail: This ensures that if any command in a pipeline fails