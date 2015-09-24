# Rescuable
Just a little helper to easily render errors for your API.

### Features
- Error wrapper
- Helper to render from your controller classes
- Easily translate your errors messages
- Lightweight

## What does it do?
This little helper will render errors like that:
```
HTTP/1.1 403
Content-Type: application/json; charset=UTF-8

{
  "id": "invalid_card",
  "message": "You have no permission to proceed"
}
```

## Installation
Include to your Gemfile
```ruby
gem 'rescuable', '~> 0.1.0'
```

Or install directly in your terminal
```bash
gem install rescuable
```

## Usage

### Ruby integration
The installation automatically includes the renderer helper in the ```ActionController::Base```.

### Manually integration
If you're not using Ruby on Rails, that's not a problem at all. You just have to include the renderer helper in your controller class like that:

```ruby
include Rescuable::Helpers::RendererController
```

### How to render errors
You just have to call ```UsersController#render_error```
```ruby
class UsersController < ActionController::Base
  rescuable_error :invalid_auth, :forbidden

  before_action :authenticate!

  private

  def authenticate!
    render_error :invalid_auth, status: 401, message: 'Invalid authorization' unless current_user
  end
end
```

It will render it:
```
HTTP/1.1 401
Content-Type: application/json; charset=UTF-8

{
  "id": "invalid_auth",
  "message": "Invalid authorization"
}
```

But that would be against our premisse *not-repeat-yourself*. So we can fix it with these steps:
#### 1 - Register the error
First of all, you have to register the error ID and its status:

```ruby
class UsersController < ActionController::Base
  rescuable_error :invalid_auth, :forbidden
  rescuable_error :server_error, 500

  # ...
end
```

#### 2 - Render it in an easier way
```ruby
class UsersController < ActionController::Base
  rescuable_error :invalid_auth, :forbidden

  before_action :authenticate!

  private

  def authenticate!
    render_error :invalid_auth, message: 'Your authentication is no longer valid' unless current_user
  end
end
```

By the way, we already thought in record errors:
```ruby
class UsersController < ActionController::Base
  # ...

  def create
    @user = User.new(name: nil)
    if @user.save
      render json: @user
    else
      render_record_error @user
    end
  end
end
```
It will render it:
```
HTTP/1.1 422
Content-Type: application/json; charset=UTF-8

{
  "id": "invalid_record",
  "message": "Name can't be blank"
}
```

Under the hood, that's just a wrapper which implements the method ```#to_error```. You also can [easily hack it](https://github.com/dhyegofernando/rescuable/blob/master/lib/rescuable/record_error.rb) following our example.

### Translate your messages
```yaml
pt-BR:
  rescuable:
    errors:
      messages:
        invalid_auth: Você não parece estar autenticado
```

Call the method just using the error ID
```ruby
class UsersController < ActionController::Base
  rescuable_error :invalid_auth, :forbidden

  before_action :authenticate!

  private

  def authenticate!
    render_error :invalid_auth unless current_user
  end
end
```

It will render it:
```
HTTP/1.1 401
Content-Type: application/json; charset=UTF-8

{
  "id": "invalid_auth",
  "message": "Você não parece estar autenticado"
}
```

### Overriding renderer method
By default our default renderer method will show errors in JSON but you can easily override its behaviour:

```ruby
class UsersController < ActionController::Base
  # ...

  protected

  def error_renderer(error)
    # override it here
  end
end
```

## Maintainer
[Dhyego Fernando](https://github.com/dhyegofernando)
