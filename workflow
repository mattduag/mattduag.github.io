name: Minify BipPip JavaScript Files

on:
  push:
    branches: [main]

jobs:
  minify:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Minify JavaScript files
        run: |
          find ./BipPip -type f -name 'BipPip-*.js' ! -name '*.min.js' -exec npx uglify-js {} -o {}.min.js --compress --mangle \;

      - name: Commit changes
        run: |
          git add ./BipPip/*.min.js          
          git commit -m "Minify JavaScript files in BipPip folder" || echo "No changes to commit"          
          git push https://x-access-token:${{ secrets.PERSONAL_TOKEN }}@github.com/${{ github.repository }} HEAD:main