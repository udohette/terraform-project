import json
from datetime import datetime
from urllib.request import urlopen
from urllib.error import URLError, HTTPError


def load_services(path):
    with open(path, "r") as file:
        return json.load(file)


def check_service(service):
    name = service["name"]
    url = service["url"]

    try:
        response = urlopen(url, timeout=5)
        code = response.getcode()

        return {
            "name": name,
            "url": url,
            "status": "reachable",
            "http_code": code
        }

    except HTTPError as error:
        return {
            "name": name,
            "url": url,
            "status": "http_error",
            "http_code": error.code
        }

    except URLError as error:
        return {
            "name": name,
            "url": url,
            "status": "unreachable",
            "error": str(error.reason)
        }


def save_json_report(results, path):
    report = {
        "generated_at": datetime.now().isoformat(),
        "results": results
    }

    with open(path, "w") as file:
        json.dump(report, file, indent=2)


def save_text_summary(results, path):
    with open(path, "w") as file:
        file.write(f"Service report generated at {datetime.now().isoformat()}\n")

        for result in results:
            line = f"{result['name']} - {result['status']}"

            if "http_code" in result:
                line += f" (HTTP {result['http_code']})"

            if "error" in result:
                line += f" - {result['error']}"

            file.write(line + "\n")


def main():
    services = load_services("services.json")
    results = []

    for service in services:
        result = check_service(service)
        results.append(result)

        print(f"{result['name']}: {result['status']}")

    save_json_report(results, "health_report.json")
    save_text_summary(results, "health_report.txt")

    print("Reports saved")


if __name__ == "__main__":
    main()
