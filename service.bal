import ballerina/http;
import ballerina/io;

type Lecturer record {
    string staffNumber;
    string officeNumber;
    string staffName;
    string title;
    string[] courses;
};

// In-memory data store for lecturers (we would use a database in a real scenario)
map<string, Lecturer> lecturers = {};

service /faculty/api/v1 on new http:Listener(8080) {

    // Add a new lecturer
    resource function addLecturer(http:Request request, http:Response response) {
        Lecturer lecturer = request.getJsonPayload<Lecturer>();
        lecturers[lecturer.staffNumber] = lecturer;
        response.setStatusCode(201);
        response.setJsonPayload(lecturer);
    }

    // Get all lecturers
    resource function getAllLecturers(http:Request request, http:Response response) {
        Lecturer[] lecturerList = lecturers.values();
        response.setJsonPayload(lecturerList);
    }

    // Get details of a specific lecturer by staff number
    resource function getLecturerByStaffNumber(http:Request request, http:Response response, string staffNumber) {
        if (lecturers.hasKey(staffNumber)) {
            response.setJsonPayload(lecturers[staffNumber]);
        } else {
            response.setStatusCode(404);
        }
    }

    // Update an existing lecturer's information
    resource function updateLecturer(http:Request request, http:Response response, string staffNumber) {
        if (lecturers.hasKey(staffNumber)) {
            Lecturer updatedLecturer = request.getJsonPayload<Lecturer>();
            lecturers[staffNumber] = updatedLecturer;
            response.setStatusCode(204);
        } else {
            response.setStatusCode(404);
        }
    }

    // Delete a lecturer's record by staff number
    resource function deleteLecturer(http:Request request, http:Response response, string staffNumber) {
        if (lecturers.hasKey(staffNumber)) {
            lecturers.remove(staffNumber);
            response.setStatusCode(204);
        } else {
            response.setStatusCode(404);
        }
    }
}
