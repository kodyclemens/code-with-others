$(document).ready(function(){
  $.get('/teams.json', function(data) {
    for (let i = 0; i < data.length; i++) {
      let id = data[i].id;
      let title = data[i].name;
      let desc = data[i].description;
      let goals = data[i].goals;
      let slack = data[i].communication_method;
      let image = data[i].avatar_url;
      let today = Date.now();
      let creationDate = Date.parse(data[i].created_at) / today;
      let daysAgo = '';

      $('#title-' + id).text(title);
      $('#desc-' + id).text(desc);
      $('#goals-' + id).text(goals);
      $('#slack-' + id).text(slack);
      $('#image-' + id).attr('src', image);
      $('#button-' + id).append('<a href="#" class="btn btn-primary">View Group</a>');

      if (creationDate < 1) {
        daysAgo = 'today';
      }
      else {
        daysAgo = `${creationDate.floor()} days ago`;
      }

      for (let x in data[i].users) {
        if (data[i].users[x].id === data[i].creator_id) {
          let creator = data[i].users[x].username;
          let userID = data[i].users[x].id;
          let creatorProfile = `<a href="/users/${userID}">${creator}</a>`;
          $('#creator-' + id).text(`Created ${daysAgo} by: `);
          $('#creator-' + id).append(creatorProfile);
        }
      }
    }
  });
});