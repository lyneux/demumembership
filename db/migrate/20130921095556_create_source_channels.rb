class CreateSourceChannels < ActiveRecord::Migration
  def change
    create_table :source_channels do |t|
      t.string :channel

      t.timestamps
    end
  end
end
