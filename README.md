<!--
To convert this file to html:

    gem install markup redcloth
    markup README.md [-F]
    open README.html

You may want to install the markdown syntax for vim:

    http://www.vim.org/scripts/script.php?script_id=2882

-->
# Civshare: A CivChoice Merchant Gateway Client for Ruby

## CivChoice

CivChoice allows managment of chritable giving activities.  Funding your
account generates an immediate tax deductible contribution to a nonprofit, and
issues Civ at a rate of 1:1 for each dollar you put in.  The Civ are used as
digital currency to move your real dollars to support the causes you care
about, generating payments to nonprofits.

The benefits of this approach are

* privacy: your employer can't see what charities are the beneficiary of
  workplace giving

* direct action: you can contribute to causes you care about, instead of
  leaving decision making to boards and committees that manage larger
  charitable funds

* timeliness: have funds available in your account to respond to acts of god,
  schedule funding around optimal tax benefits and even carry a balance
  between tax years

* impact: Civ can be used for any charitable cause by any nonprofit, supporing
  restricted giving and accountability for nonprofits (over 1 million good
  causes are currently in the CivChoice catalog).

## The CivChoice Merchant Program

The CivChoice Merchant Program exists as an easy interface to send charitable
gift cards to your customers or business contacts.  By providing a name,
amount of civ, and a default charity, you can deliver a gift card through
email to the desired recipient.

The gift card, if left unclaimed, will be contributed to the default charity
you specify after 30 days.  During the 30 day window the recipient can claim
the gift using a code supplied in the card, and decide to direct the funds to
their favorite nonprofit instead of the default.  Regardless of who recieves
the final benefit, the merchant receives the benefit of the tax deduction.

This program can be used to incentivise purchases, as a loyalty program, or as
a corporate gift program.

## Setup

* Log into CivChoice
* Edit your profile / create a merchant account
* Fund the account
* Generate a secret key

(TBD)
* select default charity
* get url endpoint

## Use

```ruby
charity_id = 7 # local food bank
merchant_id = 27 # my account number

client = Civshare.new("secret_key")

# for test mode
client.set_url = 'https://devsite.cirrusmio.com/merchant-test'

report = []
unrewarded_purchases.each do |p|
  response = client.transact email: p.email,
                             amount: p.reward_amount,
                             default_charity: charity_id 
  if response.success?
    p.rewarded
  else
    report[p.id] = response.message
  end
end
p report
```

## Support

Use the public mailing list and forum for support, or the live-chat option on
the CivChoice site.
