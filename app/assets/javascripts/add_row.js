function addSkillEventListener() {
  var addRowLink = document.getElementById("addRowLink");
  var tableBody = document.getElementById("tableBody");
  var templateRow = document.getElementById("templateRow");
  const rows = tableBody.querySelectorAll("tr");
  var index = 1;
  function addTableRow() {
    if (rows > 5) {
      alert("Pokemon can only have 4 skills!");
      return;
    }

    var newRow = templateRow.cloneNode(true);
    newRow.removeAttribute("id");
    newRow.removeAttribute("style");

    var selectedTags = document.querySelector(
      "#pokemon_pokemon_skills_attributes_0_skill_id"
    );
    // selectedTags.name =
    //   "pokemon[pokemon_skills_attributes][" + index + "][skill_id]";
    // selectedTags.id =
    //   "pokemon_pokemon_skills_attributes_" + index + "_skill_id";
    // selectedTags.removeAttribute("disabled");
    tableBody.appendChild(newRow);
    index = index + 1;
    if (index == 4) {
      index = 0;
    }
  }

  addRowLink.addEventListener("click", function (event) {
    event.preventDefault();
    addTableRow();
  });
}
document.removeEventListener("turbolinks:load", addSkillEventListener);

document.addEventListener("turbolinks:load", addSkillEventListener);
