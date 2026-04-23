@Version: 1
@LastUpdated: 2026-04-22 14:40:24.730623+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 509822f8-d30c-4819-9520-d9fc5b98f8bd
@TestID: REQ010
@Persona: general

Scenario: Inadequate Facilities and Conditions
	Given the Entity has submitted its exposition to the CAA
	When the CAA reviews the information provided by the Entity regarding facilities, working conditions, equipment, tools, processes, personnel, organization and coordination
	Then the CAA determines that the Entity's facilities, working conditions, equipment, tools, processes, personnel, organization and coordination are inadequate to discharge their obligations under the requirements of the RAE(PC) scheme
	And the Entity is denied approval for practical flight training