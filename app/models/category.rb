require 'csv'
class Category < ApplicationRecord
    has_many :posts, :dependent => :destroy

    def self.to_csv
        # Select the attributes that are needed in csv
        attribs = %w{id name}
        # iterate over all the passed products and one by one create row of the csv
        CSV.generate(headers: true) do |csv|
            csv << attribs
            all.each do |c|
                csv << attribs.map{ |attr| c.send(attr) }
            end
        end
    end
end
