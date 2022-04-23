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
                title: {type: 'string'},
                slug: {type: 'string'},
                shortText: {type: 'string'},
                longText: {type: 'string'},
                mainImage: {type: 'string'}
            }
        }
    }

    static get relationMappings() {
        return {
            hasMainImage: {
                relation: Model.HasOneRelation,
                modelClass: Image,
                join: {
                    from: 'post.image_id',
                    to: 'image.id'
                }
            }
        }
    }
}