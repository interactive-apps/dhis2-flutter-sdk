final Map<String, dynamic> sampleProgramRelationship = {
  "pager": {"page": 1, "pageCount": 1, "total": 8, "pageSize": 50},
  "relationshipTypes": [
    {
      "name": "Case to Focus",
      "id": "dPolzYwmUyN",
      "fromConstraint": {
        "program": {
          "name": "Malaria case diagnosis, treatment and investigation",
          "id": "qDkgAbB5Jlk"
        }
      },
      "toConstraint": {
        "program": {"name": "Malaria focus investigation", "id": "M3xtLkYBlKI"}
      }
    },
    {
      "name": "Focus to Case",
      "id": "Mv8R4MPcNcX",
      "fromConstraint": {
        "program": {"name": "Malaria focus investigation", "id": "M3xtLkYBlKI"}
      },
      "toConstraint": {
        "program": {
          "name": "Malaria case diagnosis, treatment and investigation",
          "id": "qDkgAbB5Jlk"
        }
      }
    },
    {
      "name": "Index case to cases",
      "id": "m6XJSapEvOa",
      "fromConstraint": {
        "program": {
          "name": "Malaria case diagnosis, treatment and investigation",
          "id": "qDkgAbB5Jlk"
        }
      },
      "toConstraint": {
        "program": {
          "name": "Malaria case diagnosis, treatment and investigation",
          "id": "qDkgAbB5Jlk"
        }
      }
    }
  ]
};
