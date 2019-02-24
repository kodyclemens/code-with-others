class Team {
  constructor(id, title, desc, goals, slack, image, created) {
    this.id = id;
    this.title = title;
    this.desc = desc;
    this.goals = goals;
    this.slack = slack;
    this.image = image;
    this.created = created;
  }

  makeLink() {
    return `<a href="/teams/${this.id}" class="btn btn-primary">View Team</a>`;
  }

  ageMessage() {
    const creationDate = Date.parse(this.created) / Date.now();

    if (creationDate < 1) {
      return 'today';
    }
    else {
      return `${creationDate.floor()} days ago`;
    }
  }
}

$(document).ready(function(){
  $.get('/teams.json', function(data) {
    for (let i = 0; i < data.length; i++) {
      const id = data[i].id;
      const title = data[i].name;
      const desc = data[i].description;
      const goals = data[i].goals;
      const slack = data[i].communication_method;
      const image = data[i].avatar_url;
      const created_at = data[i].created_at;

      const team = new Team(id, title, desc, goals, slack, image, created_at);

      $('#title-' + id).text(team.title);
      $('#desc-' + id).text(team.desc);
      $('#goals-' + id).text(team.goals);
      $('#slack-' + id).text(team.slack);
      $('#image-' + id).attr('src', team.image);
      $('#button-' + id).append(team.makeLink());

      for (let x in data[i].users) {
        if (data[i].users[x].id === data[i].creator_id) {
          let creator = data[i].users[x].username;
          let userID = data[i].users[x].id;
          let creatorProfile = `<a href="/users/${userID}">${creator}</a>`;
          $('#creator-' + id).text(`Created ${team.ageMessage()} by: `);
          $('#creator-' + id).append(creatorProfile);
        }
      }
    }
  });
});