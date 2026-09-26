# VertaPane Privacy Policy

Public hosting for the [VertaPane](https://chrome.google.com/webstore) Chrome
extension privacy policy, served via GitHub Pages.

This repository contains **only** the privacy policy page. The extension source
code is not published here.

## Why this repository exists

The Chrome Web Store requires a publicly reachable privacy policy URL for any
extension that handles user data. GitHub Pages on the free tier requires a public
repository, so the policy is split into this repository to keep the extension
source private.

## Contents

| File | Purpose |
| --- | --- |
| `index.html` | The privacy policy itself |
| `privacy-policy.css` | Styling |
| `localization.js` | Korean/English switching based on browser language |
| `icons/icon-32.png` | Favicon |

The page has no build step, no dependencies, and no analytics or tracking. It
renders in Korean or English automatically from `navigator.language`.

## Keeping it in sync with the extension

These files are copied from the extension source so that the hosted policy and
the in-extension policy never diverge. After changing the policy in the
extension, re-run:

```bash
./sync.sh /path/to/extension
```

Then commit and push. GitHub Pages redeploys automatically.
