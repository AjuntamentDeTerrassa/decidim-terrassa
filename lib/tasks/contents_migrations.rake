# frozen_string_literal: true

namespace :populate_tasks do
  namespace :contents_migrations do
    desc "migrate space images to hero content blocks"
    task migrate_spaces_hero_blocks: [:environment] do
      migrate_spaces(Decidim::ParticipatoryProcess.all, "participatory_process_homepage", %w(banner_image hero_image))
      migrate_spaces(Decidim::Assembly.all, "assembly_homepage", %w(banner_image hero_image))
      migrate_spaces(Decidim::ParticipatoryProcessGroup.all, "participatory_process_group_homepage", "hero_image")
    end
  end
end

def migrate_spaces(spaces_list, scope_name, space_attachment_attributes)
  space_attachment_attributes = [space_attachment_attributes] unless space_attachment_attributes.is_a?(Array)
  spaces_list.each do |space|
    hero_content_block = Decidim::ContentBlock.find_by(scope_name:, scoped_resource_id: space.id, manifest_name: "hero")
    next if hero_content_block.blank?

    hero_attachment = hero_content_block.attachments.find_by(name: "background_image")
    next if hero_attachment.blank?
    next if hero_attachment.file.attached?

    blob = get_blob(space, space_attachment_attributes)

    if blob.blank?
      puts "No image found for space #{space.class.name} #{space.id}"
    else
      puts "Image migrated in space #{space.class.name} #{space.id}"
      hero_attachment.file.attach(blob)
    end
  rescue ActiveStorage::FileNotFoundError
    puts "Skipped due to errors accessing blob content..."
  end
end

def get_blob(space, attachment_attributes)
  blob = nil
  attachment_attributes.each do |attachment_attribute|
    next if blob.present?
    next unless space.send(attachment_attribute).is_a?(ActiveStorage::Attached)
    next unless space.send(attachment_attribute).attached?

    space.send(attachment_attribute).blob.open do |_|
      # Force exception
    end

    blob = space.send(attachment_attribute).blob
  end

  blob
end
