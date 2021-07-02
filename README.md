# Lead Backend Engineer Challendge

## The Challendge
Implement Ruby on Rails app, that simulates the behavior of nested articles (guides) on resume.io.

**Context.**

> There are articles in our blog, that are part of huge online 'How to write a resume' instruction. Each of such posts is 'included' in a parent post.

> At the same time, parent post is just the same publication. On their pages, there is a menu for convenient navigation between articles of given articles set.

> Parent post example → [https://resume.io/how-to-write-a-resume](https://resume.io/how-to-write-a-resume)

> Nested post example → [https://resume.io/how-to-write-a-resume/resume-formats](https://resume.io/how-to-write-a-resume/resume-formats)

The detailed instructions could be found [here](https://www.notion.so/Lead-Backend-Engineer-Challendge-95f1574344d84437ba978b21832cd162) (in Russian).


## Installation guide

```bash
git clone https://github.com/alexeyrazuvaev/nested_routes
cd nested_routes

# install dependencies
bundle install

# prepare db
bundle exec rake db:reset

# load some pre-defined data
bundle exec rake db:seed

# start server
bundle exec rails s
```
With that, the project should be available on http://localhost:3000

## How to run specs
No surprises here, just usual RSpecs:
```bash
bundle exec rspec
```
or, if you prefer constant feedback during the development:
```bash
bundle exec guard
```

## Notes about the implementation
1) I've decided to make the Table of Contents fully dynamic to avoid 'keep the ToC actual' frictions.
2) The toolset in the first few commits is fully optional, just wanted myself to be comfy during the development.
