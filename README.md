# corbel-cookbook 

Chef cookbok to install and configure [Corbel](https://github.com/bq/corbel) platform.


## Attributes
//TODO

## Usage

### corbel::iam

Include `corbel::iam` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[bqcorbel::iam]"
  ]
}
```

### corbel::resources

Include `corbel::resources` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[bqcorbel::resources]"
  ]
}
```

### corbel::webfs

Include `corbel::webfs` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[bqcorbel::webfs]"
  ]
}
```

### corbel::evci

Include `corbel::evci` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[bqcorbel::evci]"
  ]
}
```

### corbel::oauth-server

Include `corbel::oauth-server` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[bqcorbel::oauth-server]"
  ]
}
```

### corbel::notifications

Include `corbel::notifications` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[bqcorbel::notifications]"
  ]
}
```
