+++
title = "VS Code NRF Development"
date = 2019-04-07
draft = false
authors = [
  "Nathan Genetzky",
]
tags = [
  "arm",
  "c",
  "cortex",
  "cortex-m4",
  "gcc",
  "gcc-arm-none-eabi",
  "gitlab",
  "nrf",
  "vscode",
]
categories = [
  "dojofive",
]
+++

## Objective

This post is discussing a workflow for developing C applications for Nordic
microcontrollers using VS Code. It will focus on a setup for a team that
utilizes Clang Format, Nordic SDK, and git (with Gitlab). Please note that
one particular configuration will be suggested, but the hope is to document
it in such a way that it is clear how it can be customized, not to suggest to
the optimum configuration.

Goals:

- Avoid code review discussions about code style
- Easily utilize and explore APIs of external or internal libraries
- Easily utilize revision history stored in git

## Tool Dependencies

Dependencies are assumed to be installed in the parent directory to this
project, but those locations can be modified. The versions listed are those
used at the time of writing, but not strictly required in all cases.

Required:

- [gcc-arm-none-eabi](https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads) (5_3-2016q1)
- [nRF-Command-Line-Tools](https://www.nordicsemi.com/Software-and-Tools/Development-Tools/nRF5-Command-Line-Tools) (9_8_1)
- [nRF5_SDK](https://developer.nordicsemi.com/nRF5_SDK/) (15.2.0_9412b96)

Optional:

- clang-format (6.0)

## Extension Recommendations

The file ([extensions.json](extensions.json)) below can be installed into
`${workspaceFolder}/.vscode/extensions.json` to recommend the extensions to
users of the project. Obviously, if you are not using "gitlab" or one of the
other tools then exclude that particular extension. Otherwise, you can also
search for the names in the Extensions Tab (`[Ctrl+Shift+X]`).

```json
{
    "recommendations": [
        "eamodio.gitlens",
        "fatihacet.gitlab-workflow",
        "marus25.cortex-debug",
        "ms-vscode.cpptools",
        "xaver.clang-format",
    ]
}
```

## Code Style

We use "clang-format" to standardize the code we write and to allow pull
requests to avoid subjective comments about code style. Each project will
have a defined `.clang-format` file that is `BasedOnStyle: Google`.

References:

- [Google C++ Style Guide](https://google.github.io/styleguide/cppguide.html)
- [Clang Format](https://clang.llvm.org/docs/ClangFormat.html)

With VS Code can reformat code with:

- `[Ctrl+Shift+I]` - Reformat the entire document
- `[Ctrl+K Ctrl+F]` - Reformat the selected range

## Configuring cpptools

Configuration for [cpptools](https://github.com/Microsoft/vscode-cpptools) is
unnecessary for self-contained projects, but requires a little configuration
when external libraries are utilized. First I will describe the project
structure, and then I will describe the matching `c_cpp_properties.json`
configuration.

This contained project structure ("linux-nrf-local") is designed to keep all
dependencies close together rather than installing in a way that they become
integrated with the host machine. `nordic-firmware` will be our git
repository for our project and will be considered the `${workspaceFolder}`.

```none
→ tree -L 1 -a
.
├── .gcc-arm-none-eabi -> .gcc-arm-none-eabi-5_3-2016q1/
├── .nRF5_SDK -> ./nRF5_SDK_15.2.0_9412b96/
├── nordic-firmware
├── nRF5_SDK_15.2.0_9412b96
├── nrf-cli-tools -> nRF-Command-Line-Tools_9_8_1/
└── nRF-Command-Line-Tools_9_8_1
```

Here is the configuration [c_cpp_properties.json](c_cpp_properties.json) that
will allow VSCode and IntellliSense to function optimally. Note that
`foldername/**` is the syntax to recursively search under `foldername`.

```json
{
  "configurations": [
    {
      "name": "linux-nrf-local",
      "includePath": [
        "/usr/include",
        "/usr/local/include",
        "${workspaceFolder}/../.gcc-arm-none-eabi/**",
        "${workspaceFolder}/../.nRF5_SDK/**",
        "${workspaceFolder}/**"
      ],
      "defines": [],
      "compilerPath": "${workspaceFolder}/../.gcc-arm-none-eabi/bin/arm-none-eabi-gcc",
      "cStandard": "c11",
      "cppStandard": "c++17",
      "intelliSenseMode": "clang-x64",
      "browse": {
        "path": [
          "/usr/include",
          "/usr/local/include",
          "${workspaceFolder}/../.gcc-arm-none-eabi/**",
          "${workspaceFolder}/../.nRF5_SDK/**",
          "${workspaceFolder}/"
        ],
        "limitSymbolsToIncludedHeaders": true
      }
    }
  ],
  "version": 4
}
```

## C++ Development with Visual Studio Code

The following is an excellent presentation at
[CppCon2017](https://github.com/CppCon/CppCon2017) by Rong Lu, Senior Program
Manager, at Microsoft about C++ Development with Visual Studio Code.

{{< youtube rFdJ68WbkdQ >}}

## References and Resources

- [Using Visual Studio Code for Nordic nRF5 BLE Debugging](https://electronut.in/vscode-nrf52-dev/)
- [Cortex-Debug Launch Configurations](https://marcelball.ca/projects/cortex-debug/cortex-debug-launch-configurations/)
