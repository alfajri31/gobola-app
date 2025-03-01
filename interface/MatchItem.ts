export type PageItem = {
  page : number,
  pageSize : number,
  data : MatchItem[]
}

export type MatchItem = {
  id : string
  team : string
  image : string
}
