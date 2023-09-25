import ballerina/http;
import ballerina/io;

type Lecturer record {
    string staffNumber;
    string officeNumber;
    string staffName;
    string title;
    string[] courses;
};

function addLecturer(Lecturer lecturer) returns Lecturer|error {
    http:Request request = new;
    request.setJsonPayload(lecturer);
    http:Response response = check http:post("http://localhost:8080/faculty/api/v1/lecturers", request);
    if (response.statusCode == 201) {
        return response.getJsonPayload<Lecturer>();
    } else {
        return error("Failed to add lecturer: " + response.getStringPayload());
    }
}

function getAllLecturers() returns Lecturer[]|error {
    http:Response response = check http:get("http://localhost:8080/faculty/api/v1/lecturers");
    if (response.statusCode == 200) {
        return response.getJsonPayload<Lecturer[]>();
    } else {
        return error("Failed to retrieve lecturers: " + response.getStringPayload());
    }
}

function getLecturerByStaffNumber(string staffNumber) returns Lecturer|error {
    http:Response response = check http:get("http://localhost:8080/faculty/api/v1/lecturers/" + staffNumber);
    if (response.statusCode == 200) {
        return response.getJsonPayload<Lecturer>();
    } else if (response.statusCode == 404) {
        return error("Lecturer not found");
    } else {
        return error("Failed to retrieve lecturer: " + response.getStringPayload());
    }
}

function updateLecturer(string staffNumber, Lecturer lecturer) returns error {
    http:Request request = new;
    request.setJsonPayload(lecturer);
    http:Response response = check http:put("http://localhost:8080/faculty/api/v1/lecturers/" + staffNumber, request);
    if (response.statusCode == 204) {
        return ();
    } else if (response.statusCode == 404) {
        return error("Lecturer not found");
    } else {
        return error("Failed to update lecturer: " + response.getStringPayload());
    }
}

function deleteLecturer(string staffNumber) returns error {
    http:Response response = check http:delete("http://localhost:8080/faculty/api/v1/lecturers/" + staffNumber);
    if (response.statusCode == 204) {
        return ();
    } else if (response.statusCode == 404) {
        return error("Lecturer not found");
    } else {
        return error("Failed to delete lecturer: " + response.getStringPayload());
    }
}
