# the-time-is-hometime

## Try With Docker

1. Build and run API server and other dependencies.
    ```console
    $ docker-compose up
    ```

2. Prepare database, only for the first run after building Docker containers.
    ```console
    $ docker-compose run --rm api bundle exec rails db:prepare
    ```

3. Send reservation API request.
    ```
    POST http://0.0.0.0:3000/api/v1/reservations/upsert
    ```

    **Example Payload**

    ```json
    {
        "reservation_code": "YYY12345678",
        "start_date": "2021-04-14",
        "end_date": "2021-04-18",
        "nights": 4,
        "guests": 4,
        "adults": 2,
        "children": 2,
        "infants": 0,
        "status": "accepted",
        "guest": {
            "first_name": "Wayne",
            "last_name": "Woodbridge",
            "phone": "639123456789",
            "email": "wayne_woodbridge@bnb.com"
        },
        "currency": "AUD",
        "payout_price": "4200.00",
        "security_price": "500",
        "total_price": "4700.00"
    }
    ```

    ```json
    {
        "reservation": {
            "code": "XXX12345678",
            "start_date": "2021-03-12",
            "end_date": "2021-03-16",
            "expected_payout_amount": "3800.00",
            "guest_details": {
                "localized_description": "4 guests",
                "number_of_adults": 2,
                "number_of_children": 2,
                "number_of_infants": 0
            },
            "guest_email": "wayne_woodbridge@bnb.com",
            "guest_first_name": "Wayne",
            "guest_last_name": "Woodbridge",
            "guest_phone_numbers": [
                "639123456789",
                "639123456789"
            ],
            "listing_security_price_accurate": "500.00",
            "host_currency": "AUD",
            "nights": 4,
            "number_of_guests": 4,
            "status_type": "accepted",
            "total_paid_amount_accurate": "4300.00"
        }
    }
    ```

# Development

## Prerequisites

- Ruby 2.7.5
- MySQL 5.7

## Setup

1. Install gems.
    ```console
    $ bundle install
    ```

2. Setup environment variables using `.env`.
    ```console
    $ cp .env.sample .env
    ```

3. Update `.env` file.
    ```console
    $ nano .env
    ```

4. Setup database.
    ```console
    $ bundle exec rails db:prepare
    ```

5. Run API server.
    ```console
    $ bundle exec rails server
    ```

## Other Commands

- Run unit tests.
    ```console
    $ bundle exec rspec
    ```

- Rails console.
    ```console
    $ bundle exec rails console
    ```
