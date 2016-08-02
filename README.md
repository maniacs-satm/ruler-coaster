# Ruler
Rule engine

[![Code Climate](https://codeclimate.com/github/Streetbees/ruler/badges/gpa.svg)](https://codeclimate.com/github/Streetbees/ruler)
[![Test Coverage](https://codeclimate.com/github/Streetbees/ruler/badges/coverage.svg)](https://codeclimate.com/github/Streetbees/ruler/coverage)
[![Build Status](https://travis-ci.org/Streetbees/ruler.svg?branch=master)](https://travis-ci.org/Streetbees/ruler)
## Usage

```ruby
json_rule = {
  type: "and",
  left: {
    type: "and",
    left: {
      type: "and",
      left: {
        type: "rule",
        path: "user.gender",
        operator: {
          type: "equal",
          value: "m"
        }
      },
      right: {
        type: "rule",
        path: "user.location.city",
        operator: {
          type: "equal",
          value: "London"
        }
      }
    },
    right: {
      type: "rule",
      path: "user.location.country",
      operator: {
        type: "equal",
        value: "UK"
      }
    }
  },
  right: {
    type: "rule",
    path: "user.age",
    operator: {
      type: "equal",
      value: 20
    }
  }
}
```

```ruby
data = {
  user: {
    gender: "m",
    age: 20,
    location: {
      city: "London",
      country: "UK"
    }
  }
}
```

```ruby
ruler = Ruler.parse(json_rule)

result = ruler.(data)

if result.success?
  # continue
else
  result.input # input from that failed
  result.rule # first rule that failed
end
```

## Instalation

Add this to your Gemfile:
```
gem 'ruler'
```

And then execute:

```
$> bundle install
```
