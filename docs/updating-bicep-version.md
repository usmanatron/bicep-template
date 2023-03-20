# Updating the Bicep Version

When updating the Bicep version, here are some thigns to keep in mind

## Read the changelog

Have a look at the Changelog on the [GitHub releases](https://github.com/Azure/bicep/releases) page.  Things are changing rapidly with Bicep, so you should watch out for any breaking changes.

## Change all places at once

Once you've confirmed you want to go ahead, use "Find and Replace" to change all instances of the current version at once.  The version is used in (at least) the following places:

* **[build/build.yml](../build/build.yml)** - When setting up the CI environment
* **[README.md](../README.md)** - In the Zero to Hero guide

## Check for new config values

All linter rules (bar a couple of exceptions) are configured to output an error (instead of a warning).  this is done via the [bicepconfig.json](../bicepconfig.json) file at the repository root.  You should check for new rules and decide if they should also be errors or similar.
