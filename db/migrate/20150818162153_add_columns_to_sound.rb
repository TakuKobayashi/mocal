class AddColumnsToSound < ActiveRecord::Migration
  def change
    add_column :sounds, :channel, :integer, null: false, default: 0
    add_column :sounds, :format, :string, null: false
    add_column :sounds, :bits_per_sample, :integer, null: false, default: 0
    add_column :sounds, :sample_rate, :integer, null: false, default: 0
    add_column :sounds, :total_frame_count, :integer, null: false, default: 0
    add_column :sounds, :byte_rate, :integer, null: false, default: 0
  end
end
