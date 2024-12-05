{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Bazel - https://bazel.build
    bazel-buildtools
    bazel_7

    # C++
    clang-tools
    clang_17

    # Go - https://go.dev
    golangci-lint
    goreleaser
    go-tools
    go_1_22
    gopls

    # Protocol Buffers
    protobuf

    # Rust - https://rust-lang.org
    cargo-whatfeatures
    cargo-machete
    cargo-nextest
    cargo-expand
    cargo-cache
    cargo-deny
    rustup

    # Node.js - https://nodejs.org/en
    nodePackages."@tailwindcss/language-server"
    nodePackages.typescript-language-server
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server

    nodePackages.typescript # for tsc
    nodePackages.prettier # for prettier
    #nodePackages.eslint # for eslint
    nodePackages.pnpm # pnpm > *
    nodejs_20
    eslint

    # Bun - https://bun.sh
    bun
  ];
}
