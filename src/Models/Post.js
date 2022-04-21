import {Model} from "objection";

export default class extends Model {
    static get tableName() {
        return 'post';
    }

    static get idColumn() {
        return 'id';
    }

    static get jsonSchema() {
        return {
            type: 'object',
            properties: {
                id: {type: 'integer'},
                title: {type: 'string'}
            }
        }
    }

    static get relationMappings() {
        return {}
    }
}