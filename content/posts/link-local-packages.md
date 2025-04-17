---
title: "How to link local packages using yarn & npm"
date: 2025-04-16T07:02:20+02:00
description: "Explore the methods of local package linking using Yarn and npm to enhance your development workflow."
summary: "A comprehensive guide on how to use local package linking with Yarn and npm for efficient testing and integration of interdependent packages."
tags: [yarn, npm, echarts]
---

In my organization, developing design components for multiple projects is a crucial task. These components are housed in a shared UI component repository and distributed as npm packages, ensuring both consistency and accessibility. As a part of this I had to migrate some of our legacy design components to a this unified repository. The workflow was defined by the respective team.

## Existing Workflow

1. **Move Components** First, move the design components to a shared repository. Ensure that all components are well-documented and tested prior to migration to avoid any issues down the line.

2. **Build the Package** Next, as part of the Continuous Integration (CI) process, build the package and create a preview version. This step should include tests to validate the build and ensure it performs as expected.

3. **Verify Changes** Once you have the preview version, verify the changes by updating your `package.json` file with this version. This allows you to check for compatibility and address any breaking changes before moving forward.

4. **Trigger Production Build**
   After verifying the changes, merge them to the main branch. This action will trigger the production build of the package. Make sure that the production build passes all the necessary tests to guarantee functionality.

5. **Update References**
   Following a successful production build, update the package version and all relevant references to the components from the shared repository. Also, remove the component files.

6. **Final Merge**
   Finally, after all steps are confirmed, perform a final review and merge the changes. This ensures that you have a clean and functional build ready for deployment.

As the number of components requiring updates continues to grow, and considering that some components encompass various sub-components, testing each component individually after CI builds has proven to be more time-consuming than anticipated. After exploring potential solutions to accelerate this workflow, an efficient yet often overlooked method was discovered: linking sub-packages.

## Lets explore how its done!

As with every other cli tools its a command provided by the yarn package manager designed to facilitate local development of JavaScript and Node.js projects. It allows developers to link a package they're working on locally so that they can use it in other local projects without going through the full cycle of publishing a new version to a registry. Here are some practical applications for using [yarn link](https://yarnpkg.com/cli/link):

### Linking a Local Package

1. Navigate to your package build directory and run:

   ```shell
   yarn link
   ```

Under the hood this will create a global symlink. You can inspect the symlink created by navigating to the Yarn global package location. For instance in mac os and unix like systems, it will typically be inside the `.config` directory of the user.

2. In your main project (where you want to use this package), run:

   ```shell
   yarn link <package-name>
   ```

Once you’re done testing or your local development work is completed, you should unlink the packages to return to using the versions from the package registry.

3. To unlink the package in your main project:
   ```shell
   yarn unlink <package-name>
   ```

When you use the `yarn link <package-name>` command in your main project directory, Yarn reads the global symlink that points to your local package directory and creates a symlink inside the `node_modules` folder of the current project. This integration ensures that the project now uses the local package for any imports or requires, instead of a version pulled from the npm registry.

### A Practical Example

Let's dive in with a practical example. You might have worked with the popular open-source charting rendering library called [echarts](https://echarts.apache.org/en/index.html). Without going too much into the technical details, It's a widely-used library that utilizes the [zrender](https://github.com/ecomfe/zrender) package to draw charts under the hood.

Suppose you are fixing an issue within echarts that involves changes in the codebase of zrender. Instead of waiting for the changes to be merged and appear in the zrender package, you can link your local zrender package inside echarts to test your changes immediately.

echarts uses npm as package manager but the underlying link command is same just need to swap yarn with npm. and the command will be `npm link` thats it!

Here’s how you can do it using npm:

1. Create a Global Symlink for zrender:

   - Navigate to the `zrender` codebase directory and run:
     ```shell
     npm link
     ```
   - This command creates a global symlink. On macOS and Unix-like systems, you can inspect the created symlink typically inside the `.config` directory:
     ```shell
     ls -l ~/.config/npm/link/
     ```

2. Link zrender to echarts project:

   - Navigate to your `echarts` project directory and run:
     ```shell
     npm link zrender
     ```
   - This command reads the global symlink and creates a symlink inside the `node_modules` folder of `echarts`, allowing immediate integration of your local `zrender` changes.

## Cosiderations

As with every other system, it's not all sunshine and rainbows. Here are some challenges and considerations when I faced while develpment.

- My yarn configuration was saved inside `~/.config` which is a symlink and not the exact location of the home user (I manage system configuration using [dotfiles](https://github.com/danishjoseph/dotfiles)). So the symlink which yarn generated was not pointed when observed from the config folder path. I have to manually edit the symlink using `ln -s <actual_path> <symlink_path>`

- It's crucial to remember to unlink packages once you’re done testing or your local development work is completed to avoid discrepancies and ensure you're using the correct versions from the registry.
