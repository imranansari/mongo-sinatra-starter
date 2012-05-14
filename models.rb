  # Models

  class User
    include Mongoid::Document

    field :firstName
    field :lastName
    field :phone

    embeds_many :devices
  end

  class Device
    include Mongoid::Document

    field :name
    field :type
    embedded_in :user, :inverse_of => :devices

  end