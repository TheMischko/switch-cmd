import {Model} from "objection";
import Role from "./Role.js";

export default class extends Model {
    static get tableName() {
        return 'user';
    }

    static get idColumn() {
        return 'id';
    }

    static get jsonSchema() {
        return {
            type: 'object',
            properties: {
                id: {type: 'integer'},
                login: {type: 'string'},
                password: {type: 'string'},
                firstName: {type: 'string'},
                middleName: {type: 'string'},
                lastName: {type: 'string'},
                birthday: {type: 'string'},
                phoneNumber: {type: 'string'},
                email: {type: 'string'},
            }
        }
    }

    static get relationMappings() {
        return {
            roles: {
                relation: Model.ManyToManyRelation,
                modelClass: Role,
                join: {
                    from: 'user.id',
                    through: {
                        from: 'user_has_role.user_id',
                        to: 'user_has_role.role_id'
                    },
                    to: 'role.id'
                }
            }
        }
    }
}