import Component from '@ember/component';

export default Component.extend({
  tagName: 'span',
  attributeBindings: ['icon:data-feather'],
  didInsertElement() {
    window.feather.replace();
  }
});
