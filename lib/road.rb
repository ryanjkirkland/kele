module Road
  def get_road(road_id)
    response = self.class.get("https://www.bloc.io/api/v1/roadmaps/#{road_id}", headers: { "authorization" => @token })
    JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id)
    sections = get_road(31)
    checkpoints = sections["sections"][0]["checkpoints"]
    checkpoints.each do |x|
      if x["id"] == checkpoint_id
        return x["id"] && x["body"]
      end
    end
  end
end
