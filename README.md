# Ruler
Rule engine

## 1) Usage

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

## 2) Instalation

Add this to your Gemfile:
```
gem 'ruler'
```

And then execute:

```
$> bundle install
```
