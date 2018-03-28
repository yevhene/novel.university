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

### Environment variables

#### All environments
```
export GITHUB_CLIENT_ID=YOUR_APP_ID
export GITHUB_CLIENT_SECRET=YOUR_APP_SECRET
```

#### Production
```
export SECRET_KEY_BASE=YOUR_SECRET_KEY_BASE
export GUARDIAN_SECRET_KEY=YOUR_GUARDIAN_SECRET_KEY
```

You can generate these using:
```
mix phx.gen.secret
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

## Deploy

### Checks

#### Check status
```
mix edeliver ping production
```

#### Check version
```
mix edeliver version production
```

#### Check migrations
```
mix edeliver show migrations on production
```

### Release

#### Update code
```
mix edeliver update production
```

#### Run migrations
```
mix edeliver migrate production
```

### Control

#### Start
```
mix edeliver start production
```

#### Stop
```
mix edeliver stop production
```

#### Restart
```
mix edeliver restart production
```
