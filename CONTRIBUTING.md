Contributing to Pipedriveable
=============================

#### Fork the Project

Fork the [project on GitHub](https://github.com/ljuti/pipedriveable) and check out your copy.

```
git clone https://github.com/contributor/pipedriveable.git
cd pipedriveable
git remote add upstream https://github.com/ljuti/pipedriveable.git
```

#### Create a Topic Branch

Make sure your fork is up-to-date and create a topic branch for your feature, enhancement or bug fix.

```
git checkout master
git pull upstream master
git checkout -b my-feature-branch
```

#### Install Dependencies

You can use the setup script to install dependencies for the gem and its integration tests.

```
bin/setup
```

#### Test

Ensure that you can build the project and run tests.

```
bundle exec rake
```

#### Write Tests

Try to write a test that reproduces the problem you are trying to fix or describes a feature that you want to build. Add to [spec/pipedriveable](spec/pipedriveable).

We definitely appreciate pull requests that highlight or reproduce a problem, even without a fix.

#### Write Code

Implement your feature or bug fix.

Ruby style is enforced with [Rubocop](https://github.com/bbatsov/rubocop), run `bundle exec rubocop` and fix any style issues highlighted.

It is encouraged to use [Mutant](https://github.com/mbj/mutant) to speed up code reviews. Mutant is an automated code review tool, with a side effect of producing semantic code coverage metrics.

Make sure that `bundle exec rake` completes without errors.

#### Write Documentation

Document any external behaviour in the [README](README.md)

#### Commit Changes

Make sure git knows your name and email address:

```
git config --global user.name "Your Name"
git config --global user.email "contributor@example.com"
```

Writing good commit logs is important. A commit log should describe what changed and why.

```
git add ...
git commit
```

#### Push

```
git push origin my-feature-branch
```

#### Make a Pull Request

Go to https://github.com/contributor/pipedriveable and select your feature branch. Click the "Pull Request" button and fill out the form.

#### Rebase

If you've been working on a change for a while, rebase with upstream/master.

```
git fetch upstream
git rebase upstream/master
git push origin my-feature-branch -f
```

#### Check on Your Pull Request

Go back to your Pull Request after a few minutes and see whether it passed muster with CI. Everything should look green, otherwise fix issues and amend your commit.

#### Be Patient

It is likely that your change will not be merged and that the nitpicky maintainers will ask you to do more, or fix seemingly benign problems. Hang on there!

#### Thank You

Please do know that we really appreciate and value your time and work.