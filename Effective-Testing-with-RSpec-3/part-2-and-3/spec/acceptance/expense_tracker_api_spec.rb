require 'rack/test'
require 'json'
require_relative '../../app/api'

module ExpenseTracker
  RSpec.describe 'ExpenseTrackerApi', :db do
    include Rack::Test::Methods

    def app
      ExpenseTracker::API.new
    end

    # def post_expense_xml(expense)
    #   header('Content-Type', 'text/xml')
    #
    #   post '/expenses', JSON.generate(expense)
    #   parsed = JSON.parse(last_response.body)
    #
    #   expect(last_response.status).to eq(200)
    #   expect(parsed).to include('expense_id' => a_kind_of(Integer))
    # end

    def post_expense(expense)
      post '/expenses', JSON.generate(expense)

      parsed = JSON.parse(last_response.body)

      expect(last_response.status).to eq(200)
      expect(parsed).to include('expense_id' => a_kind_of(Integer))

      expense.merge('id' => parsed['expense_id'])
    end

    pit 'records submitted expenses' do
      coffee = post_expense({
        'payee' => 'Starbucks',
        'amount' => 5.75,
        'date' => '2017-06-10'
      })

      zoo = post_expense({
        'payee' => 'Zoo',
        'amount' => 15.25,
        'date' => '2017-06-10'
      })

      groceries = post_expense({
        'payee' => 'Whole Food',
        'amount' => 95.20,
        'date' => '2017-06-11'
      })

      expect(last_response.status).to eq(200)
      parsed = JSON.parse(last_response.body)
      expect(parsed).to include('expense_id' => a_kind_of(Integer))

      get '/expenses/2017-06-10'
      expect(last_response.status).to eq(200)
      expenses = JSON.parse(last_response.body)
      expect(expenses).to contain_exactly(coffee, zoo)
    end

    # context 'with XML data' do
    #   pending 'Pending xml support'
    #   header('Content-Type', 'text/xml')
    #
    #   coffee = post_expense({
    #                           'payee' => 'Starbucks',
    #                           'amount' => 5.75,
    #                           'date' => '2017-06-10'
    #                         })
    #
    #   zoo = post_expense({
    #                        'payee' => 'Zoo',
    #                        'amount' => 15.25,
    #                        'date' => '2017-06-10'
    #                      })
    #
    #   groceries = post_expense({
    #                              'payee' => 'Whole Food',
    #                              'amount' => 95.20,
    #                              'date' => '2017-06-11'
    #                            })
    #
    #   expect(last_response.status).to eq(200)
    #   parsed = JSON.parse(last_response.body)
    #   expect(parsed).to include('expense_id' => a_kind_of(Integer))
    # end
  end
end