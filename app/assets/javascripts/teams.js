class Team {
  constructor(id, title, desc, goals, slack, image, created, github) {
    this.id = id;
    this.title = title;
    this.desc = desc;
    this.goals = goals;
    this.slack = slack;
    this.image = image;
    this.created = created;
    this.github = github;
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
      const github = data[i].repo_url;
      const team = new Team(id, title, desc, goals, slack, image, created_at, github);

      $('#title-' + id).text(team.title);
      $('#desc-' + id).text(team.desc);
      $('#goals-' + id).text(`Goals: ${team.goals}`);
      $('#slack-' + id).attr('href', team.slack);
      $('#github-' + id).attr('href', team.github);
      $('#team-' + id).attr('href', `/teams/${team.id}`);
      $('#image-' + id).attr('src', team.image);

      for (let x in data[i].users) {
        if (data[i].users[x].id === data[i].creator_id) {
          const creator = data[i].users[x].username;
          const userID = data[i].users[x].id;
          const creatorProfile = `<a href="/users/${userID}">${creator}</a>`;
          $('#creator-' + id).text(`Created ${team.ageMessage()} by: `);
          $('#creator-' + id).append(creatorProfile);
        }
      }
    }
  });
});