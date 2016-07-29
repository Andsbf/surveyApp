Fabricator(:visitor) do
  mid { Fabricate(:merchant).id }
  cid { SecureRandom.hex(8) }
end
