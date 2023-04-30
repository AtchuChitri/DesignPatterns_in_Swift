import UIKit

// Facade Pattern

// Facade is a design pattern that provides a single, simplified interface to a set of subsystems.

// It will create an Interface class/struct for all the depedency class's

// When to use

// Use this pattern whenever you have a system made up of multiple components and want to provide a simple way for users to perform complex tasks.

// we can consider Book a Appointment and info about Doctor to Patient and Patient to doctor

struct Patient {
    let name: String
    let problem: String
}

struct Doctor {
    let name: String
    let field: Specialist
    let experince: Int
}

enum Specialist {
    case ENT
    case Orthopedic
    case Neurologist
}

protocol Hospital {
    var name: String {get set}
    func Specialist() -> String
}

struct PatientRecipt: Hospital {
    var name: String
    let doctor: Doctor
    let patient: Patient
    
    func Specialist() -> String {
        return "Hi\(patient.name) welcome to \(name) Your case will Handle \(doctor.name) Specialist in \(doctor.field) has experince \(doctor.experince) in field"
    }
    
}

protocol CaseInfo {
    func nextCase() -> String
}

struct DoctorRecipt: CaseInfo {
   
    let doctor: Doctor
    let patient: Patient
    let time: String
    
    func nextCase()-> String {
        return "HI Next patient will be \(patient.name) has problem of \(patient.problem)"
    }
    
}


struct FacadeReception {
    let patientRecipt: PatientRecipt
    let doctorRecipt: DoctorRecipt
    
    func DoctorToPatient() -> String {
        return patientRecipt.Specialist()
    }
    func PatientToDoctor() -> String {
        return doctorRecipt.nextCase()
    }
}

let doctor = Doctor(name: "Girish", field: .ENT, experince: 12)

let patient = Patient(name: "Atchu", problem: "Ear")

let facade = FacadeReception(patientRecipt: PatientRecipt(name: "Care", doctor: doctor, patient: patient), doctorRecipt: DoctorRecipt(doctor: doctor, patient: patient, time: "10 am"))

print(facade.DoctorToPatient())
print(facade.PatientToDoctor())
