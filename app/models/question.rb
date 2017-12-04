class Question < ActiveRecord::Base

  has_many :answers
  belongs_to :user


def as_json(options={})
  super(:only => [:id,:title],
        :include => {
          :answers => {:only => [:id,:body]},
          :user => {:only => [:id, :name]}
        }
  )
end


end
