module Roadmap
  def get_checkpoint(checkpoint_id)

    response = self.class.get("/checkpoints/#{checkpoint_id}", headers)
    JSON.parse(response.body)
  end

  def get_roadmap(roadmap_id)

    response = self.class.get("/roadmaps/#{roadmap_id}", headers)
    JSON.parse(response.body)
  end
end
