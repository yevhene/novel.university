# novel.university

## Setup

### Deps
```
mix deps.get
```

### DB
```
mix ecto.setup
```

### Environment
```
export GITHUB_CLIENT_ID=YOUR_APP_ID
export GITHUB_CLIENT_SECRET=YOUR_APP_SECRET
```

## Run
```
mix phx.server
```

## Test
```
mix test
```

### Coverage
```
mix coveralls.html
```

## Lint
```
mix credo
```
