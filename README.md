# Capstone Project - Custom Ruby Linter

This was a really challenging capstone, to be honest. But it worth it! write code in order to check code's proper indentation, elegance, order, and help to accomplish the best practices to keep projects clean, has been very excited and tricky, but in the end, I've managed to develop some of the most basic linter methods by watching rubocop's corrections. 


# The Build

The custom Ruby linter currently checks/detects for:

- Missing/unexpected tags such as parenthesis (), brackets [] and curly brackets {}
- Trailing spaces
- Empty line error
- Missing/unexpected end
- Wrong indentation

> The following are images indicating good and bad way to code, in accordance to the mentioned methods:

## Missing/Unexpected Tag
~~~ruby

# good

module Canvas 
  def parameters(a, b)
    @a = a
    @b = b
  end
end

# bad

module Canvas 
  def parameters(a, b     <- # Missing parenthesis here
    @a = a
    @b = b
  end
end
~~~

## Trailing spaces
> Note the pipe "|" location to indicate the extra whitespace
~~~ruby

# good

class Canvas|
  def parameters(a, b)|
    @a = a|
    @b = b|
  end|
end|

# bad

class Canvas |
  def parameters(a, b)      |
    @a = a|
    @b = b|
  end|
end
~~~

## Empty line
~~~ruby

# good

module Canvas 
  def parameters(a, b)
    @a = a
    @b = b
  end
end

# bad

module Canvas 
  def parameters(a, b)
                                       # <- empty line
    @a = a
    @b = b
  end
end
~~~

## Unexpected end
~~~ruby

# good

module Canvas 
  def parameters(a, b)
    @a = a
    @b = b
  end
end

# bad

module Canvas 
  def parameters(a, b)
    @a = a
    @b = b
  end
end
end    # <- unexpected end   
~~~

## Indentation Check
~~~ruby

# good

module Canvas 
  def parameters(a, b)
    @a = a
    @b = b
  end
end

# bad

module Canvas 
  def parameters(a, b)
        @a = a
            @b = b
  end
end
~~~

## Built With
- Ruby
- RSpec for Ruby Testing


# Getting Started

Get a local copy from my repository using this command:

```
cd to the folder you will place the project
```

Once you are on the directory you want to set the project, run:

```
git clone https://github.com/mrigorir/custom-ruby-linter
```

Now, in the root of your project folder, run:

```
bundle install
```
So you can use Ruby dependencies

**To use the tester file, for checking any errors** 

Write the following command in the project's root

~~~bash
ruby bin/main tester.rb
~~~

## Optional (not necessary to run the program, but it would be useful to check written code)

> Install rubocop to correct the code you have made.

~~~bash
gem install rubocop 
~~~

Then, run `rubocop` in the terminal.

## Testing the tool

> Install rspec for test porpuses and colorize (optional) so the errors have a better look.

~~~bash
gem install rspec 
~~~

~~~bash
gem install colorize 
~~~

Run `rspec` on the terminal from the project's root.

To take into account: tester.rb file has been excluded from rubocop's corrections since this file contains on-purpose errors in order to test this tool.

## Linter results after checking tester file

![Results](img/results.png) 

# Author

👤 **Marco Parra**

- Github: [@mrigorir](https://github.com/mrigorir/)
- Twitter: [@marcoparra311](https://twitter.com/marcoparra311)
- Linkedin: [marco-parra-leal](https://www.linkedin.com/in/marco-parra-leal/)


## 🤝 Contributing

Contributions, issues and feature requests are welcome!

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Thanks to ![](https://img.shields.io/badge/Microverse-blueviolet) and their supportive community.
- Thanks to everyone committing to this project.
