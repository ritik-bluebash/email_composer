# Email Composer

This is an application that built on top of [OpenAI](https://openai.com/) APIs using [GPT-3.5](https://platform.openai.com/docs/models/gpt-3-5) (gpt-3.5-turbo) model. The main idea behind this application is to make the process of writing emails easier and error-free. With the help of OpenAI's GPT-3.5 turbo model, Email Composer generates complete email templates based on the user's input.

# Prerequisites
Before you begin, make sure you have the following installed:

* Ruby (version 3.2.0)
* Rails (version 7.0.4)

# Installation

1. Clone this repository to your local machine:
```ruby
git clone https://github.com/username/email_composer.git
```
2. Change into the project directory:
```ruby
cd email_composer
```
3. Install the required gems:
```ruby
bundle install
```
4. Set up rails credentials:

Contact concern developer for `development.key` for development environment credentials or run the following command to edit your Rails credentials:
```ruby
rails credentials:edit -e development
```
This will open the credentials file in your default editor. Add any sensitive information (such as API keys or passwords) to this file.

You can then access your credentials in your application code using the `Rails.application.credentials` object. For example:

```ruby
api_key = Rails.application.credentials.api_key
db_password = Rails.application.credentials.db_password
```

**Note:** Make sure to never commit or share your config/credentials.yml.enc file with anyone, as it contains sensitive information that should remain private.


## Usage
To use Email Composer, follow these simple steps:

* **Pick a category:**</u> Select the category of the email you want to write. Email Composer currently supports various categories, such as business, personal, formal, informal, and more.

* **Pick a topic:** Once you have selected the category, choose a topic for your email. Email Composer provides a list of topics related to the selected category.

* **Select a tone:** Select the tone of your email from the available options. Email Composer currently supports various tones, such as friendly, formal, persuasive, and more.

* **Additional note:** If you have any additional notes or specific requirements for your email, you can add them in this section.

* **Generate output:** After providing all the necessary details, click on the "Generate Email" button to generate the complete email template.

## API Endpoint
An API endpoint at `/api/v1/email/generate` that generates email templates based on the user's input. You can use this endpoint to integrate Email Composer into your own applications or services.

## License
Email Composer is licensed under the MIT License. See the LICENSE file for more information.
