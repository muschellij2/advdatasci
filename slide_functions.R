rinline <- function(code) { 
  sprintf('<code class="r">``` `r %s` ```</code>', code) 
}
rcode <- function(code) { 
  sprintf('<code class="r">%s</code>', code) 
}
bg_slide = function(
  files_in_order, 
  folder = "../imgs/", 
  suffix = ".png",
  titles = rep("", length(files_in_order)),
  positions = rep("center", length(files_in_order)),
  size = rep("100%", length(files_in_order))
){
  n_files = length(files_in_order)
  files_in_order = paste0(files_in_order, suffix)
  folder = rep(folder, length.out = n_files)
  size = rep_len(size, length.out = n_files)
  top_cat = paste0("---\nbackground-image: url(", folder)
  bottom_cat = paste0(")\nbackground-size: ", size, " \n")
  bottom_cat = paste0(bottom_cat, paste0(
    "background-position: ", positions, "\n")
  )
  keep = !titles %in% ""
  titles[  keep ] = paste0("\n# ", titles[keep])
  bottom_cat = paste0(bottom_cat, titles)
  res = paste0(top_cat, files_in_order, bottom_cat, "\n")
  cat(res, sep = "")
}

center_slide = function(title) {
  res = paste0("---\nclass: inverse, middle, center\n",
         "# ", title, "\n\n")
  cat(res, sep = "")
}