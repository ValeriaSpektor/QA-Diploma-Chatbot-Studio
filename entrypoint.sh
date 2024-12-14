#!/bin/bash

# Fail immediately if any command exits with a non-zero status
set -e

# Run Playwright tests
echo "Running Playwright tests..."
npx playwright test

# Generate Allure Report
echo "Generating Allure Report..."
npx allure generate ./allure-results --clean -o ./allure-report

# Serve Allure Report
echo "Serving Allure Report..."
npx http-server ./allure-report -p 8080 &

