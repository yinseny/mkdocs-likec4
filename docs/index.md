# LikeC4 for MkDocs

[MkDocs](https://www.mkdocs.org/) plugin for embedding [LikeC4](https://likec4.dev/) diagrams.

## Requirements

- [`likec4`](https://likec4.dev/tooling/cli/)
- `graphviz` (optional, only when [use_dot](#use_dot) is enabled)

Check out the sample [Dockerfile](https://github.com/doubleSlashde/mkdocs-likec4/blob/main/Dockerfile) for how you can provide the likec4 and graphviz dependencies.

## Installation

1. Install the plugin via `pip`:
  ```shell
  pip install mkdocs-likec4
  ```
2. Add the plugin to your `mkdocs.yml`:
```yaml
plugins:
  - search
  - likec4
```

That's it! The plugin automatically:

- Discovers all projects by scanning for `likec4.config.json` files (**other configs formats are not supported yet!**)
- Generates separate web components for each project
- Loads web components into the document as required

## Configuration

### use_dot

By default mkdocs-likec4 uses the bundled WASM layout engine, matching the behaviour of the `likec4` preview server.

You can opt into local graphviz binaries (which avoids known WASM [memory issues](https://github.com/likec4/likec4/issues?q=Memory%20type:Bug)) with `use_dot: true`. Note that this might result in a different layout than what the LikeC4 preview renders.

```yaml
plugins:
  - search
  - likec4:
      use_dot: true
```

### color_scheme

Sets the default color scheme for all diagrams. Possible values:

- `auto` (default): diagrams follow the current MkDocs theme and react instantly when the palette toggle is switched.
- `light` / `dark`: pins all diagrams to the chosen scheme.

```yaml
plugins:
  - search
  - likec4:
      color_scheme: light
```

Individual diagrams can override the global setting (see [color-scheme](#view-options) below).

## Usage

Use the `likec4-view` code block and specify the view-id in the body to embed a LikeC4 diagram:

--8<-- "usage.md"

This will embed the diagram from the current LikeC4 project, or the root project if this is a single
project setup.

### View Options

You may provide the following options on the opening fence line:

- `browser=true|false`

    Whether to show views browser popup/Whether the view is interactive. Possible values: `true` 
    or `false` (default: `true`)

- `dynamic-variant=diagram|sequence`

    How a dynamic view should be rendered. Possible values: diagram or sequence (default: `diagram`)

- `project=<project-name>`

    The LikeC4 project to use for this view (for multi-project setups)

- `color-scheme=auto|light|dark`

    Overrides the global [color_scheme](#color_scheme) for this diagram. `auto` keeps the diagram
    in sync with the MkDocs theme; `light` / `dark` pin it to that scheme.

## Examples

### Specify project

If you want to embed a diagram from a specific project outside the projects scope,
use the `project` parameter:

--8<-- "project-usage.md"

<div class="result" markdown>
```likec4-view project=deployment
index
```
</div>

!!! danger

    If you don't specify a project in a multi-project setup, and the page it not under a 
    `likec4.config.json` file, the build will fail:
    > Error: Specify exact project, known: [...]
