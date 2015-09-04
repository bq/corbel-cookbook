# corbel-cookbook

Chef cookbok to install and configure [Corbel](https://github.com/corbel-platform/corbel) platform.


## Attributes
//TODO

## Usage

### corbel::iam

Include `corbel::iam` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[corbel::iam]"
  ]
}
```

### corbel::resources

Include `corbel::resources` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[corbel::resources]"
  ]
}
```

### corbel::webfs

Include `corbel::webfs` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[corbel::webfs]"
  ]
}
```

### corbel::evci

Include `corbel::evci` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[corbel::evci]"
  ]
}
```

### corbel::oauth

Include `corbel::oauth` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[corbel::oauth]"
  ]
}
```
