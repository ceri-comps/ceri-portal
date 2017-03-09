# ceri-portal

teleports the content to another location in the dom.

### [Demo](https://ceri-comps.github.io/ceri-portal)


# Install

```sh
npm install --save-dev ceri-portal
```

## Usage
- [general ceri component usage instructions](https://github.com/cerijs/ceri#i-want-to-use-a-component-built-with-ceri)
- in your project
```coffee
window.customElements.define("ceri-portal", require("ceri-portal"))
```
```html
<ceri-portal>
  <span>Will be appended to body</span>
</ceri-portal>
<ceri-portal target="#somewhere">
  <span>Will be appended to element with ID somewhere</span>
</ceri-portal>
```

For examples see [`dev/`](dev/).

#### Props
Name | type | default | description
---:| --- | ---| ---
target | String | - | where the content will be appended. Defaults to `document.body`. Uses `document.querySelector`.

# Development
Clone repository.
```sh
npm install
npm run dev
```
Browse to `http://localhost:8080/`.

## License
Copyright (c) 2016 Paul Pflugradt
Licensed under the MIT license.
